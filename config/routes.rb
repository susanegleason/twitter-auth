Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
              name: 'Accept',
              value: 'application/vnd.twitter-photos-server.com; version=1' },
              defaults: { format: :json }) do
    constraints AuthorizedConstraint.new do
      # add authenticated resources
    end
  end

  # add unauthenticated resources
end
