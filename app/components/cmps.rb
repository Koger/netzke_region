class Cmps < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Cmp"
  end
end