class CmpSpecialityGrid < Netzke::Basepack::Grid
  js_configure do |c|
    c.title = "Специальности набора"
  end

  def configure(c)
    super
    c.model = "CmpSpeciality"
    c.columns = [
     {:name => :train_level__train_level_name, :header => "TrainLevel", width: 85},
     {:name => :speciality__speciality_name, :header => "Speciality", width: 300},
     {name: :cmp_speciality_qual, flex: 1},
     {name: :cmp_speciality_ins_date, hidden: true},
     {name: :cmp_speciality_edt_date, hidden: true},
     {name: :print_schedule, hidden: true}
   ]
  end

  def preconfigure_record_window(c)
    super
    c.form_config.klass = CmpSpecialityForm
    c.width = 600
  end
end