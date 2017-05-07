require 'active_support/hash_with_indifferent_access'

class BaseModel < WatirModel

  attr_accessor :id

  def self.convert(hash, *args)
    hash.deep_symbolize_keys!
    id = hash.delete :id

    model = super
    model.tap { |m| m.id = id }
  end
  #
  # def to_hash
  #   keys.each_with_object({}) do |key, hash|
  #     value = send(key)
  #     next if value.nil?
  #     hash[key] = process_value(value)
  #   end
  # end
  #
  # def process_value(value, allow_nil: false)
  #   case value
  #   when WatirModel
  #     allow_nil ? value.to_schema : value.to_hash
  #   when Array
  #     value.map do |v|
  #       hash = process_value(v, allow_nil: allow_nil)
  #       if v.is_a?(Model) && v.ngp_requires_id?
  #         {id: nil}.merge(hash)
  #       else
  #         hash
  #       end
  #     end
  #   else
  #     value
  #   end
  # end
  #
  # def to_json(opt={})
  #   to_hash.to_json(opt)
  # end
  #
  # def eql?(other)
  #   equal = true
  #   keys.each do |k|
  #     unless send(k) == other.send(k)
  #       log.debug "#{k} is #{other.send(k)} not #{send(k)}"
  #       equal = false
  #     end
  #   end
  #   equal
  # end
  #
  # alias_method :==, :eql?

end
