class VillageGrid < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Village"
    # Declaring columns
    c.columns = [:name, :district__name]
  end
end