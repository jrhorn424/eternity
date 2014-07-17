Fabricator(:claim) do
  number { Random.alphanumeric(6).upcase }
  filed_on { Random.date }
  amount_cents { Random.number(6) }
  policy
  claimants(rand: 3) { |_,i| Fabricate(:claimant) }
end
