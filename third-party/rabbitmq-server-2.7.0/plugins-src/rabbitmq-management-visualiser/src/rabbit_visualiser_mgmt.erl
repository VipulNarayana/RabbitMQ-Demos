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
%%   The Original Code is RabbitMQ Visualiser.
%%
%%   The Initial Developer of the Original Code is VMware, Inc.
%%   Copyright (c) 2011-2011 VMware, Inc.  All rights reserved.
%%

-module(rabbit_visualiser_mgmt).

-behaviour(rabbit_mgmt_extension).

-export([dispatcher/0, web_ui/0]).
dispatcher() -> [{["all"],        rabbit_mgmt_wm_all, []},
                 {["all", vhost], rabbit_mgmt_wm_all, []}].
web_ui()     -> [{javascript, <<"visualiser.js">>}].
