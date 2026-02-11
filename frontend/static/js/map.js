// frontend/static/js/map.js - Leaflet Map Integration

let map = null;
const nearbyLocations = [
    { name: 'City General Hospital', distance: '0.5 km', type: 'Hospital', lat: 23.0225, lng: 72.5714, phone: '+91 79 1234 5678' },
    { name: 'MedPlus Pharmacy', distance: '0.3 km', type: 'Pharmacy', lat: 23.0235, lng: 72.5724, phone: '+91 79 2345 6789' },
    { name: 'Apollo Hospital', distance: '1.2 km', type: 'Hospital', lat: 23.0245, lng: 72.5734, phone: '+91 79 3456 7890' },
    { name: 'HealthCare Medical Store', distance: '0.8 km', type: 'Pharmacy', lat: 23.0255, lng: 72.5744, phone: '+91 79 4567 8901' },
    { name: 'Sterling Hospital', distance: '1.5 km', type: 'Hospital', lat: 23.0215, lng: 72.5700, phone: '+91 79 5678 9012' },
    { name: 'Wellness Pharmacy', distance: '0.6 km', type: 'Pharmacy', lat: 23.0250, lng: 72.5710, phone: '+91 79 6789 0123' }
];

function showMapModal() {
    document.getElementById('mapModal').classList.remove('hidden');
    loadLocations();
    
    // Initialize map after a short delay to ensure container is visible
    setTimeout(() => {
        initializeMap();
    }, 100);
}

function closeMapModal() {
    document.getElementById('mapModal').classList.add('hidden');
    
    // Clean up map
    if (map) {
        map.remove();
        map = null;
    }
}

function loadLocations() {
    const locationsList = document.getElementById('locationsList');
    
    locationsList.innerHTML = nearbyLocations.map((loc, idx) => `
        <div class="glassmorphism-strong rounded-xl p-4 hover:bg-white/30 transition-all cursor-pointer" onclick="focusLocation(${idx})">
            <div class="flex items-start justify-between mb-3">
                <div class="flex-1">
                    <h3 class="text-white font-semibold">${loc.name}</h3>
                    <p class="text-white/70 text-sm">${loc.type}</p>
                </div>
                <span class="text-white/80 text-xs glassmorphism px-3 py-1 rounded-lg font-medium">${loc.distance}</span>
            </div>
            
            <div class="space-y-2">
                ${loc.phone ? `
                    <div class="flex items-center text-white/60 text-sm">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                        </svg>
                        ${loc.phone}
                    </div>
                ` : ''}
                
                <button onclick="getDirections(event, ${loc.lat}, ${loc.lng}, '${loc.name}')" class="w-full text-sm text-white/90 hover:text-white flex items-center justify-center gap-2 glassmorphism p-2 rounded-lg hover:bg-white/20 transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    </svg>
                    Get Directions
                </button>
            </div>
        </div>
    `).join('');
}

function initializeMap() {
    // Remove existing map if any
    if (map) {
        map.remove();
    }
    
    // Initialize map centered on Ahmedabad
    map = L.map('map').setView([23.0225, 72.5714], 13);
    
    // Add OpenStreetMap tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors',
        maxZoom: 19
    }).addTo(map);
    
    // Add markers for each location
    nearbyLocations.forEach((loc, idx) => {
        // Custom icon based on type
        const iconColor = loc.type === 'Hospital' ? '#ef4444' : '#8b5cf6';
        const iconHtml = `
            <div style="
                background: ${iconColor};
                border-radius: 50%;
                width: 36px;
                height: 36px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 3px solid white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.3);
            ">
                <svg style="width: 20px; height: 20px; color: white;" fill="currentColor" viewBox="0 0 20 20">
                    ${loc.type === 'Hospital' ? 
                        '<path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"/>' : 
                        '<path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>'}
                </svg>
            </div>
        `;
        
        const icon = L.divIcon({
            html: iconHtml,
            className: '',
            iconSize: [36, 36],
            iconAnchor: [18, 18],
            popupAnchor: [0, -18]
        });
        
        const marker = L.marker([loc.lat, loc.lng], { icon: icon }).addTo(map);
        
        // Create popup content
        const popupContent = `
            <div style="min-width: 200px;">
                <h3 style="font-weight: bold; margin-bottom: 8px; color: #1f2937;">${loc.name}</h3>
                <p style="color: #6b7280; font-size: 14px; margin-bottom: 4px;">${loc.type}</p>
                <p style="color: #8b5cf6; font-size: 13px; margin-bottom: 8px;">📍 ${loc.distance}</p>
                ${loc.phone ? `<p style="color: #6b7280; font-size: 13px; margin-bottom: 8px;">📞 ${loc.phone}</p>` : ''}
                <button onclick="getDirections(event, ${loc.lat}, ${loc.lng}, '${loc.name}')" style="
                    background: linear-gradient(135deg, #667eea, #764ba2);
                    color: white;
                    border: none;
                    padding: 8px 16px;
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 13px;
                    width: 100%;
                    margin-top: 8px;
                ">
                    Get Directions
                </button>
            </div>
        `;
        
        marker.bindPopup(popupContent);
    });
    
    // Fit map to show all markers
    const group = new L.featureGroup(map._layers);
    if (Object.keys(group._layers).length > 0) {
        map.fitBounds(group.getBounds().pad(0.1));
    }
}

function focusLocation(index) {
    const loc = nearbyLocations[index];
    
    if (map) {
        map.setView([loc.lat, loc.lng], 16, {
            animate: true,
            duration: 1
        });
        
        // Find and open the marker popup
        map.eachLayer(layer => {
            if (layer instanceof L.Marker) {
                const pos = layer.getLatLng();
                if (pos.lat === loc.lat && pos.lng === loc.lng) {
                    layer.openPopup();
                }
            }
        });
    }
}

function getDirections(event, lat, lng, name) {
    event.stopPropagation();
    
    // Open Google Maps with directions
    const url = `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}&destination_place_id=${encodeURIComponent(name)}`;
    window.open(url, '_blank');
}
