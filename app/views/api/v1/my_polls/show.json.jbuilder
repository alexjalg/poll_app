#json.(@poll,:id,:title,:description,:user_id,:expires_at)
json.partial! "api/v1/resource", recurso: @poll