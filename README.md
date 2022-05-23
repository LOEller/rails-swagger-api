# README

## Swagger + Rails API Demo

API docs viewable at /api-docs

Helpful resources:
 - rails API demo app: https://github.com/YuKitAs/rails-rest-api
 - rails status code symbols mapping: https://gist.github.com/mlanett/a31c340b132ddefa9cca
 - rswag documentation: https://github.com/rswag/rswag
 - rswag setup guides: https://medium.com/@clarkjohnson_85334/adding-swagger-docs-to-a-rails-6-api-using-rswag-a3e8bc577986 and https://medium.com/@sushildamdhere/how-to-document-rest-apis-with-swagger-and-ruby-on-rails-ae4e13177f5d (neither of these actually worked for me straight up but with the rswag docs I figured it out)


## Some useful things:

 - to regenerate the `swagger.yaml` and update the docs: `rake rswag:specs:swaggerize`
 - to get an ActiveRecord console with heroku: `heroku run rails c -a APPNAME`