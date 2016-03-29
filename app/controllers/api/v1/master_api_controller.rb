class Api::V1::MasterApiController < ApplicationController
    layout "api/v1/application"  
    after_action :cor_set_access_control_headers
    
    def cor_set_access_control_headers
        #headers['Access-Control-Allow-Origin'] = "https://angular-js-alexjalg.c9.io"
        headers['Access-Control-Allow-Origin'] = "*"
        headers['Access-Control-Allow-Methods'] = "POST,GET,DELETE,OPTIONS"
        headers['Access-Control-Allow-Headers'] = "Origin,Content-Type,Accept,Authorization,Token"
    end
end