import NMapsMap

class NaverMapViewEventDelegate: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFIndoorSelectionDelegate {
    private weak var sender: NaverMapController?

    private let initializeConsumeSymbolTapEvents: Bool
    private var animated: Bool = true

    init(sender: NaverMapControlSender, initializeConsumeSymbolTapEvents: Bool) {
        self.sender = (sender as! NaverMapController)
        self.initializeConsumeSymbolTapEvents = initializeConsumeSymbolTapEvents
    }

    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        sender?.onMapTapped(nPoint: NPoint.fromCGPoint(point), latLng: latlng)
    }

    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        sender?.onSymbolTapped(symbol: symbol) ?? initializeConsumeSymbolTapEvents
    }

    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        self.animated = animated
        sender?.onCameraChange(cameraUpdateReason: reason, animated: animated)
    }

    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        sender?.onCameraChange(cameraUpdateReason: reason, animated: animated)
    }

    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        self.animated = animated
        sender?.onCameraChange(cameraUpdateReason: reason, animated: animated)
    }

    func mapViewCameraIdle(_ mapView: NMFMapView) {
        sender?.onCameraIdle()
    }

    func indoorSelectionDidChanged(_ indoorSelection: NMFIndoorSelection?) {
        sender?.onSelectedIndoorChanged(selectedIndoor: indoorSelection)
    }

    func registerDelegates(mapView: NMFMapView) {
        mapView.touchDelegate = self
        mapView.addCameraDelegate(delegate: self)
        mapView.addIndoorSelectionDelegate(delegate: self)
    }
}
