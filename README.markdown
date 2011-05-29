Rails Decorators
================

This gem makes it easy to apply the decorator pattern to the models in a Rails application.

## Why use decorators?

Helpers, as they're commonly used, are a bit odd. In both Ruby and Rails we approach everything from an Object-Oriented perspective, then with helpers we get procedural.

The job of a helper is to take in data or a data object and output presentation-ready results. We can do that job in an OO fashion with a decorator.

In general, a decorator wraps an object with presentation-related accessor methods. For instance, if you had an `Article` object, then a decorator might add instance methods like `.formatted_published_at` or `.formatted_title` that output actual HTML.

## How is it implemented?

To implement the pattern in Rails we can:

1. Write a module with the decoration methods
2. Inject that module into the model
3. Utilize those methods within our view layer

We're not polluting the model layer because it's code stays purely persistence and business logic. The decorator is a part of the view layer, and that's the only place we'd utilize the decoration methods.

## How do you utilize this gem in your application?

Here are the steps to utilizing this gem:

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

## Possible Decoration Methods

Here are some ideas of what you might do in decorator methods:

* Implement output formatting for `to_csv`, `to_json`, or `to_xml`
* Format dates and times using `strftime`
* Implement a commonly used representation of the data object like a `.name` method that combines `first_name` and `last_name` attributes

## Example Using a Decorator

Say I have a publishing system with `Article` resources. My designer decides that whenever we print the `published_at` timestamp, it should be constructed like this:

```html
<span class='published_at'>
  <span class='date'>Monday, May 6</span>
  <span class='time'>8:52AM</span>
</span>
```

Could we build that using a partial? Yes. A helper? Uh-huh. But the point of the decorator is to encapsulate logic just like we would a method in our models. Here's how to implement it.

First, follow the steps above to add the dependency, update your bundle, then run the `rails generate decorator:setup` to prepare your app.

Each decorator is dedicated to a single model. Since we're talking about the `Article` model we'll create an `ArticleDecorator` module. You could do it by hand, but use the provided generator:

```
rails generate decorator:model Article
```

Now open up the created `app/decorators/article_decorator.rb` and you'll find an `ArticleDecorator` module. 

Why is this a `module`? A traditional decorator implementation uses a second class to completely encapsulate the subject. But because Ruby has such a flexible object model, this isn't necessary. We instead build the decorator as a module and inject that module into the original class. This allows the model's source code to remain purely persistence and business logic while the module contains all the decorations. Neither the model nor the controller layers need to know about the existence of the decorator methods, they can live up at the view layer.

Within the module, notice that we `extend ActiveSupport::Concern`. This library allows us to mask some of the ugliness of Ruby modules and utilize a simplified syntax. (Here's a great tutorial: http://www.fakingfantastic.com/2010/09/20/concerning-yourself-with-active-support-concern/)

Next you'll see commented-out samples for how to utilize Rails' view helper methods. In this example we could make use of the `content_tag` helper, so uncomment the `TagHelper` line. (API Reference: http://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html)

Move below those comments and you'll find a nested module named `InstanceMethods`. Any methods you add inside here will be available as instance methods on your object. Within the module, we would add this method:

```ruby
def formatted_published_at
  date = content_tag(:span, published_at.strftime("%A, %B %e").squeeze(" "), :class => 'date')
  time = content_tag(:span, published_at.strftime("%l:%M%p").delete(" "), :class => 'time')
  content_tag :span, date + time, :class => 'published_at'
end
```

*ASIDE*: Unfortunately, due to the current implementation of `content_tag`, you can't use the style of sending the content is as a block or you'll get an error about `undefined method 'output_buffer='`. Passing in the content as the second argument, as above, works fine.

Save the decorator file and it'll be auto-loaded on the next request just like the rest of your application. From the view, you can access it like any model method presuming you have an instance of `Article` in the variable `@article`:

```
<%= @article.formatted_published_at %>
```

Ta-da! Object-oriented data formatting for your view layer. Below is the complete decorator with extra comments removed:

```ruby
module ArticleDecorator
  extend ActiveSupport::Concern
  include ActionView::Helpers::TagHelper
  
  module InstanceMethods
    def formatted_published_at
      date = content_tag(:span, published_at.strftime("%A, %B %e").squeeze(" "), :class => 'date')
      time = content_tag(:span, published_at.strftime("%l:%M%p").delete(" "), :class => 'time')
      content_tag :span, date + time, :class => 'published_at'
    end
  end
end
```

## License

(The MIT License)

Copyright © 2011 Jeff Casimir

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.