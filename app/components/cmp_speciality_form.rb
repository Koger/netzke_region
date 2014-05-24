# Our custom IssueForm - it has a custom layout and pre-assigned model
class CmpSpecialityForm < Netzke::Basepack::Form
  def configure(c)
    c.model = 'CmpSpeciality'
    c.record_id = CmpSpeciality.first.try(:id) # default record
    super
    c.items = [
        :name,
        {
            layout: :hbox, border: false, defaults: {border: false}, items: [{
              flex: 1,
              layout: :anchor,
              defaults: {anchor: "-8"},
              items: [:speciality__name, :train_level__name]
            },{
              flex: 1,
              layout: :anchor,
              defaults: {anchor: "100%"},
              items: [:cmp_speciality_ins_date, :cmp_speciality_edt_date]
            }]
        },
        {name: :cmp_speciality_qual, hide_label: true}
    ]
  end
end