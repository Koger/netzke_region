class ReviewerGrid < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "DiplomReviewer"
  end
end