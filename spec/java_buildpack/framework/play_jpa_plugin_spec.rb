# Encoding: utf-8
# Cloud Foundry Java Buildpack
# Copyright 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'
require 'component_helper'
require 'java_buildpack/framework/play_jpa_plugin'

module JavaBuildpack::Framework

  describe PlayJpaPlugin do
    include_context 'component_helper'

    it 'should detect Play 2.0 application',
       app_fixture: 'framework_play_jpa_plugin_play20' do

      expect(component.detect).to eq("play-jpa-plugin=#{version}")
    end

    it 'should detect staged application',
       app_fixture: 'framework_play_jpa_plugin_staged' do

      expect(component.detect).to eq("play-jpa-plugin=#{version}")
    end

    it 'should detect dist application',
       app_fixture: 'framework_play_jpa_plugin_dist' do

      expect(component.detect).to eq("play-jpa-plugin=#{version}")
    end

    it 'should not detect non-JPA application',
       app_fixture: 'container_play_2.1_dist' do

      expect(component.detect).to be_nil
    end

    it 'should copy additional libraries to the lib directory',
       app_fixture: 'framework_play_jpa_plugin_dist',
       cache_fixture: 'stub-play-jpa-plugin.jar' do

      component.compile

      expect(additional_libs_dir + "play-jpa-plugin-#{version}.jar").to exist
    end

  end

end
