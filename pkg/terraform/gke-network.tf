/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "gke-network" {
  source  = "terraform-google-modules/network/google"
  project_id   = "${var.project_id}"
  network_name = "{{.Spec.Network.Name}}"

  subnets = [
    {
      subnet_name   = "{{.Spec.Network.Spec.SubnetName}}"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "${var.region}"
    },
  ]

  secondary_ranges = {
    "{{.Spec.Network.Spec.SubnetName}}" = [
      {
        range_name    = "{{.Spec.Network.Name}}-${var.cluster_name}-pod-range"
        ip_cidr_range = "{{.Spec.Network.Spec.PodSubnetRange}}"
      },
      {
        range_name    = "{{.Spec.Network.Name}}-${var.cluster_name}-service-range"
        ip_cidr_range = "{{.Spec.Network.Spec.ServiceSubnetRange}}"
      },
    ]}
}

