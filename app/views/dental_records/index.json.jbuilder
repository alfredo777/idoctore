json.array!(@dental_records) do |dental_record|
  json.extract! dental_record, :id, :user_id, :clinical_history_id, :note
  json.url dental_record_url(dental_record, format: :json)
end
