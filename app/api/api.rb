class API < Grape::API
  mount Common::Ping

  # add_swagger_documentation base_path: 'api', api_version: 'v1'
end
