class Depts < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Dept"
  end
end