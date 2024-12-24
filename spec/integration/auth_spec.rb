require "swagger_helper"

RSpec.describe "Authentication", type: :request do
  path "/api/v1/auth/registration" do
    post "Registration new account" do
      tags "Auth"
      produces "application/json"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "phihai91@1.com" },
          password: { type: :string, example: "@StrongPassword123!" }
        },
        required: ["email", "password"]
      }
      response "201", "Account successfully created" do
        let(:user) { { email: "new@example.com", password: "ValidPassword123!" } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/login" do
    post "Login to account" do
      tags "Auth"
      produces "application/json"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "user@example.com" },
          password: { type: :string, example: "StrongPassword123!" }
        },
        required: ["email", "password"]
      }

      response "401", "Unauthorized - Invalid credentials" do
        let(:user) { { email: "wrong@example.com", password: "wrongpassword" } }
        run_test!
      end
    end
  end
end

# Use this command to re-create swagger.yaml
# rake rswag:specs:swaggerize