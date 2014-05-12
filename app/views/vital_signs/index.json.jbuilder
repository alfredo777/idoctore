json.array!(@vital_signs) do |vital_sign|
  json.extract! vital_sign, :id, :weight, :blood_pressure_up, :blood_pressure_down, :pulse, :height, :breathing, :temperature
  json.url vital_sign_url(vital_sign, format: :json)
end
