class DiplomTopicGrid < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "DiplomTopic"
  end
end