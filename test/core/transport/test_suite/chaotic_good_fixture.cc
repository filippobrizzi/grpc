// Copyright 2023 gRPC authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "test/core/transport/test_suite/chaotic_good_fixture_helpers.h"

using grpc_event_engine::experimental::EventEngine;

namespace grpc_core {

TRANSPORT_FIXTURE(ChaoticGood) {
  auto resource_quota = MakeResourceQuota("test");
  EndpointPair control_endpoints =
      CreateEndpointPair(event_engine.get(), resource_quota.get(), 1234);
  EndpointPair data_endpoints =
      CreateEndpointPair(event_engine.get(), resource_quota.get(), 4321);
  auto channel_args =
      ChannelArgs()
          .SetObject(resource_quota)
          .SetObject(std::static_pointer_cast<EventEngine>(event_engine));
  auto client_transport =
      MakeOrphanable<chaotic_good::ChaoticGoodClientTransport>(
          std::move(control_endpoints.client),
          chaotic_good::OneDataEndpoint(std::move(data_endpoints.client)),
          ChannelArgs().SetObject(resource_quota), event_engine);
  auto server_transport =
      MakeOrphanable<chaotic_good::ChaoticGoodServerTransport>(
          channel_args, std::move(control_endpoints.server),
          chaotic_good::OneDataEndpoint(std::move(data_endpoints.server)),
          event_engine);
  return ClientAndServerTransportPair{std::move(client_transport),
                                      std::move(server_transport)};
}

}  // namespace grpc_core
