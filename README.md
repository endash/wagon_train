# wagon_train

This is a proof/sketch-of-concept. This exists solely as a basis for discussion, not active development.

## The general idea

Your app and your database are not the same thing. In fact, your app and your database are pretty much the canonical example of a major architectural boundary, i.e. two things that are not the same. Why, then, are developers encouraged to treat their database schema as just another part of their application source? There are three prevalent anti-patterns at play, here:

1.  The incorporation of migrations for a database into a specific application's repository, despite the fact that database design is a wholly separate concern, and a database can easily be used by more than one application.
2.  The generation of a large number of small migrations for each production release, tightly coupling one's database schema not just to the application, but to the minute detail of day-to-day development.
3.  The execution of migrations as the responsibility of an application during its deploy phase, along with the production application having the requisite permissions to modify the database schema.

Your database design should be a first-class concern, just like your backend, JS front-end, native apps, etc are all their own projects.

## The specific idea

Wagon Train is migrations on steroids (in both the buffed-up sense, and the anti-inflammatory sense). It:

1.  separates the concern of the database schema into its own project, with its own version/release organization scheme;
2.  gets the app developer out of the tiresome business of managing migrations for a database that might not even exist yet, by exposing a single, editable schema file for changes required during the development process;
3.  handles preparing & deploying releases of the database schema by automatically generating the necessary migration, tagging each release as part of its version control, and verifying the integrity of the existing schema before executing any changes;
4.  operates as a specification at the application level, by checking the database schema upon application launch against the required schema version.

Your schema becomes an interface or contract. As a formalized abstraction, it not-so-gently encourages thoughtful maintenance of that boundary, rather than encouraging application devs to run roughshod over database design by right.

## Based on Sequel

I don't know if there's a use-case for migrations with non-SQL-based databases, but even if there is that's out-of-scope. Most operations wrap Sequel calls, and the POC, currently, assumes the database is PostgreSQL.

## There's a CLI

Schema management is primarily via the `wagon` binary. Right now the only command is `release`, which is hardcoded to assume day-to-day work is done on a `develop` branch, and production releases are committed to the `master` branch. In a release version of Wagon Train this will be configurable, as well as have the option of using tags, etc, rather than specific branches. The release command also just generates an automatic migration as a diff between the current and previous schemas, without any allowance for customizing the migration. This is obviously not intended to be the final behaviour.

## Schema Example

Currently the schema API is based on Sequel, but is not identical. The CLI assumes a `schema.rb` file in the project root. An example `schema.rb`:

```ruby
WagonTrain::DSL::Schema.load do |db|
  db.table(:users) do |t|
    t.uuid :id, primary_key: true
    t.column :name, String, null: false
    t.date :birthday, null: false
  end

  db.table(:posts) do |t|
    t.uuid :id, primary_key: true
    t.text :title, null: false
    t.text :body, null: false
    t.uuid :user_id, foreign_key: :users
  end
end
```

The migration API will likely differ from Sequel substantially. The primary motivation there is to have a readable API that can double as clear identifiers for use with migration hooks, to provide a mechanism for customizing the migration without needing to generate the entire migration as an editable file.

For instance, adding an `age` column to the users table might look like:

```ruby
table(:users).add_column(:age).opts(:integer, null: false)
```

And rather than spitting out a preliminary migration file that then has to be edited just prior to release, we can provide hooks to the developer as such:

```ruby
after(table(:users).add_column(:age)) do
  # ... sql to set the age columns based on the birth date
end
```

This is 100% subject to change
