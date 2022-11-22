# frozen_string_literal: true

require 'swagger_helper'

schema = load_schema(:vehicle)

RSpec.describe 'Vehicle SWAGGER', resource: :vehicle, schema: schema do
  origin_let
  let(:permitted_fleet_ids) { [SecureRandom.uuid, SecureRandom.uuid] }

  path "#{SWAGGER_SERVICE_PATH_PREFIX_DEFAULT}/v1/vehicles" do
    origin_parameter

    test_index(skip403: true)
    test_create
  end

  path "#{SWAGGER_SERVICE_PATH_PREFIX_DEFAULT}/v1/vehicles/{id}" do
    before { stub_http(:get, 'destroy_unapproved') }

    origin_parameter
    id_parameter

    test_show
    test_update
    test_destroy
  end
end
