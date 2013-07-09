class CompressedBag
  include Mongoid::Document

  belongs_to :bag

  # Since mongoid doesn't support :through relationships, we have to manually create them.
  def institution
    bag.description_object.institution
  end

  def institution_id
    institution.id
  end
end
