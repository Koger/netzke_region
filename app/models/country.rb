class Country < GeoEntity
  #Страна
  self.table_name = 'region'
  self.primary_key= 'id'

  # Relationships
  # имеет в составе области, областные центры
  has_many :regions, foreign_key: 'owner'
end