package finalproject.simulations;

import inet.common.scenario.ScenarioManager;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import ned.IdealChannel;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.PgwStandard;
import simu5g.nodes.Ue;
import simu5g.nodes.Upf;
import simu5g.nodes.eNodeB;
import simu5g.world.radio.ChannelControl;

@license(LGPL);
//
// Network Topology
//
network Network
{
    @display("bgb=1002.3001,552.50006,,,0;bgi=background/budapest");

    submodules:
        channelControl: ChannelControl {
            @display("p=87.10001,20.800003;is=vs");
        }
        eNodeB1: eNodeB {
            @display("p=228.8,137.8");
        }
        eNodeB2: eNodeB {
            @display("p=211.90002,353.60004");
        }
        router1: Router {
            @display("p=414.70004,136.50002");
        }
        router2: Router {
            @display("p=462.8,356.19998");
        }
        coreRouter: Router {  // core
            @display("p=594.1001,235.30003");
        }
        pgw: PgwStandard {
            @display("p=728.0001,235.30003;is=s");
        }
        edgeRouter: Router {  // edge
            @display("p=907.40015,235.30003");
        }
        standardHost: StandardHost {
            @display("p=763.1,55.899998");
        }
        binder: Binder {
            @display("p=88.40001,171.60002;is=vs");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=88.40001,72.80001;is=vs");
        }
        Configurator: Ipv4NetworkConfigurator {
            @display("p=88.40001,122.20002;is=vs");
        }
        upf1: Upf {
            @display("p=592.8001,137.80002");
        }
        upf2: Upf {
            @display("p=594.1001,353.60004");
        }
        InternetHost: WirelessHost {
            @display("p=907.40015,353.60004");
        }
        ue: Ue {
            @display("p=291.20004,78.00001;is=s");
        }
        ue1: Ue {
            @display("p=283.40002,401.70004;is=s");
        }
        ue2: Ue {
            @display("p=341.90005,409.50006;is=s");
        }
        scenarioManager: ScenarioManager {
            @display("p=88.40001,224.90002;is=vs");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=88.40001,271.70004;is=vs");
        }
    connections allowunconnected:
        // Connect InternetHost >> edgeRouter
        edgeRouter.ethg[0] <--> IdealChannel <--> InternetHost.ethg[0];
        // Connect upf1 >> router1 && coreRouter
        router1.ethg[1] <--> IdealChannel <--> upf1.ethg[0];
        standardHost.ethg[0] <--> IdealChannel <--> upf1.ethg[1];
        upf1.ethg[2] <--> IdealChannel <--> coreRouter.ethg[0];
        // Connect upf2 >> router2 && coreRouter
        router2.ethg[1] <--> IdealChannel <--> upf2.ethg[0];
        upf2.ethg[1] <--> IdealChannel <--> coreRouter.ethg[1];
        // Core connections coreRouter >> PGW && edgeRouter
        coreRouter.ethg[2] <--> IdealChannel <--> pgw.ethg[0];
        pgw.ethg[1] <--> IdealChannel <--> edgeRouter.ethg[1];
        // eNodeB >> routers
        eNodeB1.ppp <--> IdealChannel <--> router1.ethg[0];
        eNodeB2.ppp <--> IdealChannel <--> router2.ethg[0];
}
