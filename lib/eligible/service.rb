module Eligible
  class Service < APIResource
    COMMON_ATTRIBUTES = [:timestamp, :eligible_id, :mapping_version, :additional_insurance]
    STATUS_ATTRIBUTES = [:type, :coverage_status]
    VISITS_ATTRIBUTES = [:not_covered, :comments, :precertification_needed, :visits_in_network, :visits_out_network]
    COPAYMENT_ATTRIBUTES = [:copayment_in_network, :copayment_out_network]
    COINSURANCE_ATTRIBUTES = [:coinsurance_in_network, :coinsurance_out_network]
    DEDUCTIBLE_ATTRIBUTES = [:deductible_in_network, :deductible_out_network]

    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def all
      error ? nil : to_hash
    end

    def visits
      keys = COMMON_ATTRIBUTES + STATUS_ATTRIBUTES + VISITS_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def copayment
      keys = COMMON_ATTRIBUTES + STATUS_ATTRIBUTES + COPAYMENT_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def coinsurance
      keys = COMMON_ATTRIBUTES + STATUS_ATTRIBUTES + COINSURANCE_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def deductible
      keys = COMMON_ATTRIBUTES + STATUS_ATTRIBUTES + DEDUCTIBLE_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end
  end
end