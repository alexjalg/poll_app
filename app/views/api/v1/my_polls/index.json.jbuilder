json.array! @polls do |poll|
    json.type "my_polls"
    json.id poll.id
    json.attributes poll.attributes
end