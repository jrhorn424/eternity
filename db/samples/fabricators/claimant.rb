Fabricator(:claimant) do
  first_name { Random.firstname }
  last_name { Random.lastname }
end
