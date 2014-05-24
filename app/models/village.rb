class Village < GeoEntity
  # Село, поселок
  self.table_name = 'region'
  self.primary_key= 'id'

  # Relationships
  # является частью/относится к району/рай. центру
  belongs_to :district, foreign_key: 'owner'
end