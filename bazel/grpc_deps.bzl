# Copyright 2021 The gRPC Authors
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
"""Load dependencies needed to compile and test the grpc library as a 3rd-party consumer."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//bazel:grpc_python_deps.bzl", "grpc_python_deps")

# buildifier: disable=unnamed-macro
def grpc_deps():
    """Loads dependencies need to compile and test the grpc library."""

    if "io_opencensus_cpp" not in native.existing_rules():
        http_archive(
            name = "io_opencensus_cpp",
            sha256 = "46b3b5812c150a21bacf860c2f76fc42b89773ed77ee954c32adeb8593aa2a8e",
            strip_prefix = "opencensus-cpp-5501a1a255805e0be83a41348bb5f2630d5ed6b3",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/census-instrumentation/opencensus-cpp/archive/5501a1a255805e0be83a41348bb5f2630d5ed6b3.tar.gz",
                "https://github.com/census-instrumentation/opencensus-cpp/archive/5501a1a255805e0be83a41348bb5f2630d5ed6b3.tar.gz",
            ],
        )

    if "envoy_api" not in native.existing_rules():
        http_archive(
            name = "envoy_api",
            sha256 = "e525a6fb6e6ed3eef1eec6bef3da9b5708e471f0f9335a7604df14a4b386231e",
            strip_prefix = "data-plane-api-f8b75d1efa92bbf534596a013d9ca5873f79dd30",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/envoyproxy/data-plane-api/archive/f8b75d1efa92bbf534596a013d9ca5873f79dd30.tar.gz",
                "https://github.com/envoyproxy/data-plane-api/archive/f8b75d1efa92bbf534596a013d9ca5873f79dd30.tar.gz",
            ],
        )


    if "opencensus_proto" not in native.existing_rules():
        http_archive(
            name = "opencensus_proto",
            sha256 = "b7e13f0b4259e80c3070b583c2f39e53153085a6918718b1c710caf7037572b0",
            strip_prefix = "opencensus-proto-0.3.0/src",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/census-instrumentation/opencensus-proto/archive/v0.3.0.tar.gz",
                "https://github.com/census-instrumentation/opencensus-proto/archive/v0.3.0.tar.gz",
            ],
        )

    if "com_envoyproxy_protoc_gen_validate" not in native.existing_rules():
        commit = "e52c333e6fe07fca4ed76fd09263e2fb6092c720"
        http_archive(
            name = "com_envoyproxy_protoc_gen_validate",
            sha256 = "10bedaab907d9a7a1b289579797520973c72482cfedf00cdb5f51c706b506a8e1",
            strip_prefix = "protoc-gen-validate-{commit}".format(commit=commit),
            urls = ["https://github.com/filippobrizzi/protoc-gen-validate/archive/{commit}.tar.gz".format(commit=commit)],
        )


    if "google_cloud_cpp" not in native.existing_rules():
        http_archive(
            name = "google_cloud_cpp",
            sha256 = "7ca7f583b60d2aa1274411fed3b9fb3887119b2e84244bb3fc69ea1db819e4e5",
            strip_prefix = "google-cloud-cpp-2.16.0",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/googleapis/google-cloud-cpp/archive/refs/tags/v2.16.0.tar.gz",
                "https://github.com/googleapis/google-cloud-cpp/archive/refs/tags/v2.16.0.tar.gz",
            ],
        )


# TODO: move some dependencies from "grpc_deps" here?
# buildifier: disable=unnamed-macro
def grpc_test_only_deps():
    """Internal, not intended for use by packages that are consuming grpc.

    Loads dependencies that are only needed to run grpc library's tests.
    """

    if "com_github_twisted_twisted" not in native.existing_rules():
        http_archive(
            name = "com_github_twisted_twisted",
            sha256 = "ca17699d0d62eafc5c28daf2c7d0a18e62ae77b4137300b6c7d7868b39b06139",
            strip_prefix = "twisted-twisted-17.5.0",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/twisted/twisted/archive/twisted-17.5.0.zip",
                "https://github.com/twisted/twisted/archive/twisted-17.5.0.zip",
            ],
            build_file = "@com_github_grpc_grpc//third_party:twisted.BUILD",
        )

    if "com_github_yaml_pyyaml" not in native.existing_rules():
        http_archive(
            name = "com_github_yaml_pyyaml",
            sha256 = "e34d97db6d846f5e2ad51417fd646e7ce6a3a70726ccea2a857e0580a7155f39",
            strip_prefix = "pyyaml-6.0.1",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/yaml/pyyaml/archive/6.0.1.zip",
                "https://github.com/yaml/pyyaml/archive/6.0.1.zip",
            ],
            build_file = "@com_github_grpc_grpc//third_party:yaml.BUILD",
        )

    if "com_github_twisted_incremental" not in native.existing_rules():
        http_archive(
            name = "com_github_twisted_incremental",
            sha256 = "f0ca93359ee70243ff7fbf2d904a6291810bd88cb80ed4aca6fa77f318a41a36",
            strip_prefix = "incremental-incremental-17.5.0",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/twisted/incremental/archive/incremental-17.5.0.zip",
                "https://github.com/twisted/incremental/archive/incremental-17.5.0.zip",
            ],
            build_file = "@com_github_grpc_grpc//third_party:incremental.BUILD",
        )

    if "com_github_zopefoundation_zope_interface" not in native.existing_rules():
        http_archive(
            name = "com_github_zopefoundation_zope_interface",
            sha256 = "e9579fc6149294339897be3aa9ecd8a29217c0b013fe6f44fcdae00e3204198a",
            strip_prefix = "zope.interface-4.4.3",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/zopefoundation/zope.interface/archive/4.4.3.zip",
                "https://github.com/zopefoundation/zope.interface/archive/4.4.3.zip",
            ],
            build_file = "@com_github_grpc_grpc//third_party:zope_interface.BUILD",
        )

    if "com_github_twisted_constantly" not in native.existing_rules():
        http_archive(
            name = "com_github_twisted_constantly",
            sha256 = "2702cd322161a579d2c0dbf94af4e57712eedc7bd7bbbdc554a230544f7d346c",
            strip_prefix = "constantly-15.1.0",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/twisted/constantly/archive/15.1.0.zip",
                "https://github.com/twisted/constantly/archive/15.1.0.zip",
            ],
            build_file = "@com_github_grpc_grpc//third_party:constantly.BUILD",
        )

    if "com_google_libprotobuf_mutator" not in native.existing_rules():
        http_archive(
            name = "com_google_libprotobuf_mutator",
            sha256 = "9c8f800aed088cdf89adc3eaaa66b56b4da7da041f26338aa71a2ab43d860d46",
            urls = [
                "https://storage.googleapis.com/grpc-bazel-mirror/github.com/google/libprotobuf-mutator/archive/1f95f8083066f5b38fd2db172e7e7f9aa7c49d2d.tar.gz",
                "https://github.com/google/libprotobuf-mutator/archive/1f95f8083066f5b38fd2db172e7e7f9aa7c49d2d.tar.gz",
            ],
            strip_prefix = "libprotobuf-mutator-1f95f8083066f5b38fd2db172e7e7f9aa7c49d2d",
            build_file = "@com_github_grpc_grpc//third_party:libprotobuf_mutator.BUILD",
        )

grpc_repo_deps_ext = module_extension(implementation = lambda ctx: grpc_deps())
