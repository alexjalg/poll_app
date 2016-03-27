#json.array! @polls do |poll|
#    json.partial! "api/v1/resource", recurso: poll
#end
json.partial! partial: "api/v1/resource", collection: @polls, as: :recurso