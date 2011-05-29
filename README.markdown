Rails Decorators
================

This gem makes it easy to apply the decorator pattern to the models in a Rails application.

## Why?

Helpers, as they're commonly used, are a bit odd. In both Ruby and Rails we approach everything from an Object-Oriented perspective, then with helpers we get procedural.

The job of a helper is to take in data or a data object and output presentation-ready results. We can do that job in an OO fashion with a decorator.

In general, a decorator wraps an object with presentation-related accessor methods. For instance, if you had an `Article` object, then a decorator might add instance methods like `.formatted_published_at` or `.formatted_title` that output actual HTML.

## How?

Here are the steps to utilizing this pattern:

Add the dependency to your `Gemfile`:

```
gem "rails_decorators"
```

Run bundle:

```
bundle
```

Run the setup generator to create a decorators folder and an initializer to connect your decorators with your models:

```
rails generate decorator:setup
```

Create a decorator for your model (ex: `Article`)

```
rails generate decorator:model Article
```

Open the decorator module (ex: `app/decorators/article_decorator.rb`)

Add your new formatting methods inside the `instance_methods` module

If you need access to the Rails helpers like `link_to` and `content_tag`, include the appropriate modules (commented out in the generated decorator)

Use the new methods in your views like any other model method (ex: `@article.formatted_published_at`)

## Uses

Here are some ideas of what you might do in decorator methods:

* Implement output formatting for `to_csv`, `to_json`, or `to_xml`
* Format dates and times using `strftime`
* Implement a commonly used representation of the data object like a `.name` method that combines `first_name` and `last_name` attributes
