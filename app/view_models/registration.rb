class Registration

    attr_accessor :email, :unique_id
    include ActiveModel::Conversion
    include ActiveModel::Validations

end
