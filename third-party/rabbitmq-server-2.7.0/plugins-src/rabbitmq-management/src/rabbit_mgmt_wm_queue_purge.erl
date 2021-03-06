%%   The contents of this file are subject to the Mozilla Public License
%%   Version 1.1 (the "License"); you may not use this file except in
%%   compliance with the License. You may obtain a copy of the License at
%%   http://www.mozilla.org/MPL/
%%
%%   Software distributed under the License is distributed on an "AS IS"
%%   basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
%%   License for the specific language governing rights and limitations
%%   under the License.
%%
%%   The Original Code is RabbitMQ Management Plugin.
%%
%%   The Initial Developer of the Original Code is VMware, Inc.
%%   Copyright (c) 2010-2011 VMware, Inc.  All rights reserved.
%%

-module(rabbit_mgmt_wm_queue_purge).

-export([init/1, resource_exists/2, is_authorized/2, allowed_methods/2,
         delete_resource/2]).

-include("rabbit_mgmt.hrl").
-include_lib("webmachine/include/webmachine.hrl").
-include_lib("amqp_client/include/amqp_client.hrl").

%%--------------------------------------------------------------------
init(_Config) -> {ok, #context{}}.

allowed_methods(ReqData, Context) ->
    {['DELETE'], ReqData, Context}.

resource_exists(ReqData, Context) ->
    {case rabbit_mgmt_wm_queue:queue(ReqData) of
         not_found -> false;
         _         -> true
     end, ReqData, Context}.

delete_resource(ReqData, Context) ->
    rabbit_mgmt_util:amqp_request(
      rabbit_mgmt_util:vhost(ReqData),
      ReqData, Context,
      #'queue.purge'{ queue = rabbit_mgmt_util:id(queue, ReqData) }).

is_authorized(ReqData, Context) ->
    rabbit_mgmt_util:is_authorized_vhost(ReqData, Context).
