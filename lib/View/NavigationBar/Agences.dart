import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:my_amana_app/core/bootstrap/app_repositories.dart';
import 'package:my_amana_app/core/config/app_config.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/agences/agencies_repository.dart';
import 'package:my_amana_app/features/agences/models/agency.dart';

class AgencLoc extends StatelessWidget {
  const AgencLoc({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapPage();
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final AgenciesRepository _repository = AppRepositories.agencies;
  final TextEditingController _searchController = TextEditingController();

  GoogleMapController? _mapController;
  List<Agency> _agencies = [];
  bool _isLoading = true;
  String? _errorMessage;

  final LatLng initialPosition = const LatLng(34.0209, -6.8416);

  @override
  void initState() {
    super.initState();
    _loadAgencies();
    _searchController.addListener(_handleSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearch);
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _loadAgencies({String? query}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final agencies = await _repository.fetchAgencies(query: query);
      if (!mounted) {
        return;
      }
      setState(() {
        _agencies = agencies;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Erreur lors du chargement des agences.';
        _isLoading = false;
      });
    }
  }

  void _handleSearch() {
    _loadAgencies(query: _searchController.text);
  }

  Set<Marker> _buildMarkers() {
    return _agencies
        .where((agency) => agency.lat != 0 && agency.lng != 0)
        .map((agency) => Marker(
              markerId: MarkerId(agency.id),
              position: LatLng(agency.lat, agency.lng),
              infoWindow: InfoWindow(
                title: agency.name,
                snippet: agency.address,
              ),
            ))
        .toSet();
  }

  Widget _buildMapFallback() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.map_outlined, size: 48, color: AppColors.primary),
              SizedBox(height: 12),
              Text(
                'Carte indisponible',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text(
                'Ajoutez une cle API Google Maps pour activer la carte.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.mutedText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgencyTile(Agency agency) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.store, color: AppColors.primary, size: 18),
        ),
        title: Text(agency.name),
        subtitle: Text(
          '${agency.address}, ${agency.city}',
          style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
        ),
        trailing: agency.phone == null
            ? null
            : Text(
                agency.phone!,
                style: const TextStyle(fontSize: 11),
              ),
      ),
    );
  }

  Widget _buildAgenciesPanel() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: AppColors.mutedText),
        ),
      );
    }
    if (_agencies.isEmpty) {
      return const Center(
        child: Text(
          'Aucune agence trouvee.',
          style: TextStyle(color: AppColors.mutedText),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _agencies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _buildAgencyTile(_agencies[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool mapsEnabled = AppConfig.mapsEnabled;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher une agence',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: mapsEnabled
                    ? GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: initialPosition,
                          zoom: 11.5,
                        ),
                        markers: _buildMarkers(),
                        myLocationButtonEnabled: false,
                      )
                    : _buildMapFallback(),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: _buildAgenciesPanel(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
