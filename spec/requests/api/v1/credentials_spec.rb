require 'swagger_helper'

RSpec.describe 'api/v1/credentials', type: :request do

  path '/api/v1/credentials' do

    get('list credentials') do
      tags 'Credentials'
      produces 'application/json', 'application/xml'

      response(200, 'successful') do
        run_test!
      end
    end

    post('create credential') do
      tags "Credentials"
      consumes "application/json"
      parameter name: :credential, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          env: { type: :string },
          utility_id: { type: :integer },
        },
        required: ["username", "password"],
      }

      response(201, 'successful') do
        let(:credential) { { username: "user", password: "pass" } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['username']).to eq('user')
          expect(data['password']).to eq('pass')
        end
      end

      response(422, 'invalid request') do
        let(:credential) { { username: 1 } }
        run_test!
      end
    end
  end

  path '/api/v1/credentials/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    get('show credential') do
      tags 'Credentials'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response(200, 'successful') do
        let(:id) { Credential.create(username: 'foo', password: 'bar').id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['username']).to eq('foo')
          expect(data['password']).to eq('bar')
        end
      end

      response(404, 'credential does not exist') do
        let(:id) { 3 }
        run_test!
      end
    end

    patch('update credential') do # partial update
      tags 'Credentials'
      produces 'application/json', 'application/xml'
      consumes "application/json"
      parameter name: :id, in: :path, type: :string
      parameter name: :credential, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          env: { type: :string },
          utility_id: { type: :integer },
        }
      }

      response(200, 'successful') do
        let(:id) { Credential.create(username: 'before', password: 'bar').id }
        let(:credential) { { username: "after" } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['username']).to eq('after')
          expect(data['password']).to eq('bar')
        end
      end
    end

    put('update credential') do # requires complete record
      tags 'Credentials'
      produces 'application/json', 'application/xml'
      consumes "application/json"
      parameter name: :id, in: :path, type: :string
      parameter name: :credential, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          env: { type: :string },
          utility_id: { type: :integer },
        },
        required: ["username", "password", "env", "utility_id"],
      }

      response(200, 'successful') do
        let(:id) { Credential.create(username: 'before_user', password: 'before_pass').id }
        let(:credential) { { username: "after_user", password: "after_pass" } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['username']).to eq('after_user')
          expect(data['password']).to eq('after_pass')
        end
      end
    end

    delete('delete credential') do
      tags 'Credentials'
      parameter name: :id, in: :path, type: :string

      response(204, 'successful') do
        let(:id) { Credential.create(username: 'foo', password: 'bar').id }

        run_test! do |response|
          expect(Credential.exists?(id)).to be false
        end
      end
    end
  end
end
