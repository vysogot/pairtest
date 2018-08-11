#
# Custom proxy class for the external API consumption
#

class RemoteMovie

  REMOTE_ROOT = 'https://pairguru-api.herokuapp.com'
  API_ROOT = REMOTE_ROOT + '/api/v1/movies/'

  attr :api, :title

  def initialize(title)
      @title = title
  end

  def plot
      api['plot']
  end

  def rating
      api['rating']
  end

  def poster
      REMOTE_ROOT + api['poster']
  end

  def as_json(options = {})
      { poster: poster, rating: rating, plot: plot }
  end

  private

  def api
      @api ||= JSON.parse(RestClient.get(API_ROOT + URI.encode(@title)))
      @api['data']['attributes']
  end
end
