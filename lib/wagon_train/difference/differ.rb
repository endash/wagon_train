module WagonTrain
  DifferenceSet = Struct.new(:added, :removed, :common, :changed)

  def self.differ(struct, keys)
    Proc.new do |old_value, new_value|
      diff_sets = keys.map do |key|
        if key.is_a?(Array)
          key, identity = key
          identity = identity.to_proc unless identity.is_a?(Proc)

          old_identities = old_value.send(key).map(&identity)
          new_identities = new_value.send(key).map(&identity)

          removed = old_identities - new_identities
          common = new_identities & old_identities

          changed = (common.map do |id|
            old_id = old_value.send(key).find { |x| identity.call(x) == id }
            new_id = new_value.send(key).find { |x| identity.call(x) == id }
            new_id - old_id
          end).compact

          added = (new_identities - old_identities).map do |id|
            new_value.send(key).find { |x| identity.call(x) == id }
          end
        else
          old_identities = old_value.send(key)
          new_identities = new_value.send(key)

          added = new_identities - old_identities
          removed = old_identities - new_identities
          common = new_identities & old_identities
          changed = []
        end

        if added.empty? && removed.empty? && changed.empty?
          nil
        else
          DifferenceSet.new(added, removed, common, changed)
        end
      end

      if diff_sets.compact.empty?
        nil
      else
        struct.new(new_value, old_value, *diff_sets)
      end
    end
  end
end