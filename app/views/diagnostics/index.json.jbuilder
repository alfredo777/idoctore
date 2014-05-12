json.array!(@diagnostics) do |diagnostic|
  json.extract! diagnostic, :id, :user_id, :interrogation, :physical_examination, :diagnostic_or_clinical_problem, :list_of_laboratory_studies, :required_therapies, :suggested_treatments
  json.url diagnostic_url(diagnostic, format: :json)
end
