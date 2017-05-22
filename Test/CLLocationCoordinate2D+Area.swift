//
//  CLLocationCoordinate2D+Area.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 22/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble

class CLLocationCoordinate2DAreaTest: XCTestCase {
    
    func test__fails_when_not_enough_coordinates() {
        
        expect {
            let array = [CLLocationCoordinate2D](
                repeating: CLLocationCoordinate2D.zero,
                count: 0
            )
            _ = array.area()
            return nil
        }.to(throwAssertion())
        
        expect {
            let array = [CLLocationCoordinate2D](
                repeating: CLLocationCoordinate2D.zero,
                count: 1
            )
            _ = array.area()
            return nil
        }.to(throwAssertion())
        
        expect {
            let array = [CLLocationCoordinate2D](
                repeating: CLLocationCoordinate2D.zero,
                count: 2
            )
            _ = array.area()
            return nil
        }.to(throwAssertion())
        
    }
    
    func test__triangular() {
        
        let coordinates = [
            CLLocationCoordinate2D(latitude: -0.33408522605895996, longitude: 39.58952214829947),
            CLLocationCoordinate2D(latitude: -0.3340168297290802, longitude: 39.58948390897039),
            CLLocationCoordinate2D(latitude: -0.33394575119018555, longitude: 39.5895490191667)
        ]
        
        let areaInHa = coordinates.area()
        let areaInM2 = areaInHa * 10000
        
        expect(areaInM2).to(beCloseTo(34.13, within: 1))
        
    }
    
    func test__rectangular() {
        
        let coordinates = [
            CLLocationCoordinate2D(latitude: -0.332736074924469, longitude: 39.58969474176536),
            CLLocationCoordinate2D(latitude: -0.33261001110076904, longitude: 39.58976501922113),
            CLLocationCoordinate2D(latitude: -0.3323766589164734, longitude: 39.58960896183308),
            CLLocationCoordinate2D(latitude: -0.33247455954551697, longitude: 39.5895211148043)
        ]
        
        let areaInHa = coordinates.area()
        let areaInM2 = areaInHa * 10000
        
        expect(areaInM2).to(beCloseTo(361.88, within: 1))
        
    }
    
    func test__circular() {
        
        let coordinates = [
            CLLocationCoordinate2D(latitude: -0.33220432698726654, longitude: 39.59001196268675),
            CLLocationCoordinate2D(latitude: -0.33218923956155777, longitude: 39.5900117043148),
            CLLocationCoordinate2D(latitude: -0.332174152135849, longitude: 39.5900083454794),
            CLLocationCoordinate2D(latitude: -0.3321617469191551, longitude: 39.59000266129603),
            CLLocationCoordinate2D(latitude: -0.33215269446372986, longitude: 39.58999620199618),
            CLLocationCoordinate2D(latitude: -0.3321463242173195, longitude: 39.58998948432371),
            CLLocationCoordinate2D(latitude: -0.3321416303515434, longitude: 39.58998121641823),
            CLLocationCoordinate2D(latitude: -0.3321386128664017, longitude: 39.58997191502336),
            CLLocationCoordinate2D(latitude: -0.33213794231414795, longitude: 39.58996028827804),
            CLLocationCoordinate2D(latitude: -0.33214330673217773, longitude: 39.5899465945533),
            CLLocationCoordinate2D(latitude: -0.3321496769785881, longitude: 39.58993703478156),
            CLLocationCoordinate2D(latitude: -0.33215872943401337, longitude: 39.58993005873109),
            CLLocationCoordinate2D(latitude: -0.3321681171655655, longitude: 39.58992463291357),
            CLLocationCoordinate2D(latitude: -0.3321801871061325, longitude: 39.58992075732938),
            CLLocationCoordinate2D(latitude: -0.33219292759895325, longitude: 39.58991972384022),
            CLLocationCoordinate2D(latitude: -0.33220667392015457, longitude: 39.58991998221253),
            CLLocationCoordinate2D(latitude: -0.33221907913684845, longitude: 39.58992230756307),
            CLLocationCoordinate2D(latitude: -0.3322301432490349, longitude: 39.5899261831472),
            CLLocationCoordinate2D(latitude: -0.332239530980587, longitude: 39.589931867336844),
            CLLocationCoordinate2D(latitude: -0.3322475776076317, longitude: 39.58993806827047),
            CLLocationCoordinate2D(latitude: -0.33225394785404205, longitude: 39.589947111297654),
            CLLocationCoordinate2D(latitude: -0.33225763589143753, longitude: 39.58995770455662),
            CLLocationCoordinate2D(latitude: -0.33225931227207184, longitude: 39.58996907293026),
            CLLocationCoordinate2D(latitude: -0.3322552889585495, longitude: 39.58998018292996),
            CLLocationCoordinate2D(latitude: -0.33225059509277344, longitude: 39.58999077618385),
            CLLocationCoordinate2D(latitude: -0.33224254846572876, longitude: 39.589998010600205),
            CLLocationCoordinate2D(latitude: -0.3322324901819229, longitude: 39.59000524501581),
            CLLocationCoordinate2D(latitude: -0.3322197496891022, longitude: 39.5900101540830)
        ]
        
        let areaInHa = coordinates.area()
        let areaInM2 = areaInHa * 10000
        
        expect(areaInM2).to(beCloseTo(83.93, within: 1))
        
    }
    
    func test__concav() {
     
        let coordinates = [
            CLLocationCoordinate2D(latitude: -0.3327883780002594, longitude: 39.58902964576533),
            CLLocationCoordinate2D(latitude: -0.33276088535785675, longitude: 39.58905083256214),
            CLLocationCoordinate2D(latitude: -0.33268511295318604, longitude: 39.58900277469664),
            CLLocationCoordinate2D(latitude: -0.3326549381017685, longitude: 39.58902706200916),
            CLLocationCoordinate2D(latitude: -0.33271394670009613, longitude: 39.58907822036305),
            CLLocationCoordinate2D(latitude: -0.33266767859458923, longitude: 39.5891107756595),
            CLLocationCoordinate2D(latitude: -0.33256642520427704, longitude: 39.58902912901412),
            CLLocationCoordinate2D(latitude: -0.3326616436243057, longitude: 39.5889474822725)
        ]
        
        let areaInHa = coordinates.area()
        let areaInM2 = areaInHa * 10000
        
        expect(areaInM2).to(beCloseTo(138, within: 1))
        
    }
    
    func test__finland() {
        
        let coordinates = [
            CLLocationCoordinate2D(latitude: 26.836504340171814, longitude: 69.44820382429701),
            CLLocationCoordinate2D(latitude: 26.83634340763092, longitude: 69.44801173699521),
            CLLocationCoordinate2D(latitude: 26.836504340171814, longitude: 69.44782341444363),
            CLLocationCoordinate2D(latitude: 26.836557984352112, longitude: 69.4476614557288),
            CLLocationCoordinate2D(latitude: 26.836670637130737, longitude: 69.44760119170924),
            CLLocationCoordinate2D(latitude: 26.8368798494339, longitude: 69.44763697349124),
            CLLocationCoordinate2D(latitude: 26.837148070335388, longitude: 69.44763697349124),
            CLLocationCoordinate2D(latitude: 26.837931275367737, longitude: 69.44755222706888),
            CLLocationCoordinate2D(latitude: 26.838660836219788, longitude: 69.44778763297217),
            CLLocationCoordinate2D(latitude: 26.8386447429657, longitude: 69.44792699205131),
            CLLocationCoordinate2D(latitude: 26.838473081588745, longitude: 69.44803433559048),
            CLLocationCoordinate2D(latitude: 26.838178038597107, longitude: 69.44807576628666),
            CLLocationCoordinate2D(latitude: 26.837732791900635, longitude: 69.44806823343878),
            CLLocationCoordinate2D(latitude: 26.8375825881958, longitude: 69.44812472973372),
            CLLocationCoordinate2D(latitude: 26.837260723114014, longitude: 69.44813226256181),
            CLLocationCoordinate2D(latitude: 26.837035417556763, longitude: 69.4481190801109),
            CLLocationCoordinate2D(latitude: 26.83682084083557, longitude: 69.44812849614809),
            CLLocationCoordinate2D(latitude: 26.836697459220886, longitude: 69.4481868754865)
        ]
        
        let areaInHa = coordinates.area()
        let areaInM2 = areaInHa * 10000
        
        expect(areaInM2).to(beCloseTo(4474.24, within: 1))
        
    }
    
    func test__south_africa() {
        
        let coordinates = [
            CLLocationCoordinate2D(latitude: 22.96514332294464, longitude: -33.758361837182186),
            CLLocationCoordinate2D(latitude: 22.96493947505951, longitude: -33.7583484574344),
            CLLocationCoordinate2D(latitude: 22.964826822280884, longitude: -33.758580372767064),
            CLLocationCoordinate2D(latitude: 22.964504957199097, longitude: -33.75871416978898),
            CLLocationCoordinate2D(latitude: 22.96438694000244, longitude: -33.758897025381174),
            CLLocationCoordinate2D(latitude: 22.96444594860077, longitude: -33.75912447935394),
            CLLocationCoordinate2D(latitude: 22.964783906936646, longitude: -33.75939653135224),
            CLLocationCoordinate2D(latitude: 22.965030670166016, longitude: -33.75949464825452),
            CLLocationCoordinate2D(latitude: 22.965717315673828, longitude: -33.75934747285898),
            CLLocationCoordinate2D(latitude: 22.965781688690186, longitude: -33.759004062620015),
            CLLocationCoordinate2D(latitude: 22.965540289878845, longitude: -33.758856886382155),
            CLLocationCoordinate2D(latitude: 22.965357899665833, longitude: -33.7587855281152)
        ]
        
        let areaInHa = coordinates.area()
        let areaInM2 = areaInHa * 10000
        
        expect(areaInM2).to(beCloseTo(9941.48, within: 1))
        
    }
    
}

