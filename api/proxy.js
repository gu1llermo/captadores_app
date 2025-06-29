// api/proxy.js
export default async function handler(req, res) {
  // Configurar CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  
  // Manejar preflight request
  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  try {
    // URL de tu Google Apps Script
    const GOOGLE_SCRIPT_URL = 'https://script.google.com/macros/s/AKfycbwOEYBmQwees7BsP9lZdW4rAN4EHAmedN1mzYAXEMvrwQ2_lF7NZ7LK0mHzxHyDHkuuFg/exec';
    
    const body = req.body;
    
    // Crear parámetros para la URL
    const params = new URLSearchParams({
      comando: body.comando,
      parametros: Buffer.from(JSON.stringify(body.parametros)).toString('base64'),
      encrypted: 'true'
    });

    // Hacer la petición a Google Apps Script usando GET
    const response = await fetch(`${GOOGLE_SCRIPT_URL}?${params.toString()}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    });

    const data = await response.text();
    
    // Intentar parsear como JSON
    let jsonData;
    try {
      jsonData = JSON.parse(data);
    } catch (e) {
      // Si no es JSON válido, devolver como texto
      jsonData = { data: data };
    }

    res.status(200).json(jsonData);
  } catch (error) {
    console.error('Error en proxy:', error);
    res.status(500).json({ 
      error: 'Error en el servidor proxy',
      details: error.message 
    });
  }
}