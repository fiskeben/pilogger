class EventSerializer < ActiveModel::Serializer
  attributes :id, :value, :name, :occurred_at, :timestamp
end
