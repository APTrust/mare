class TransactionalObject
  include Mongoid::Document
  include Mongoid::Timestamps

  # Since mongoid doesn't support :through relationships, we have to manually create them.
  def institution
    description_object.institution
  end

  def institution_id
    institution.id
  end
end
