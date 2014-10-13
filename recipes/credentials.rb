#
# Cookbook Name:: postgresql
# Recipe:: credentials
#
# Copyright 2013, Thomas Boerger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if Chef::Config[:solo] and not node.recipes.include?("chef-solo-search")
  log "Using attribute based postgresql credentials" do
    level :info
  end
else
  credentials = search(
    "postgresql",
    "fqdn:#{node["fqdn"]} OR id:default"
  ).first.to_hash

  node.set["postgresql"]["credentials"]["username"] = credentials["username"]
  node.set["postgresql"]["credentials"]["password"] = credentials["password"]
end
