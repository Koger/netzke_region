class DistrictGrid < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "District"
  end
end