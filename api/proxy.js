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

  if (req.method !== 'POST') {
    res.status(405).json({ error: 'Method not allowed' });
    return;
  }

  try {
    // URL de tu Google Apps Script
    const GOOGLE_SCRIPT_URL = 'https://script.google.com/macros/s/AKfycbwLEC_fzgSAwlfwAjWXVAv8fPm7y8RRdiQAJpASJISgKtDmvTeIKZ9VNnwboiYfkpQ1Ow/exec';
    
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
        'User-Agent': 'Mozilla/5.0 (compatible; Proxy/1.0)',
      },
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.text();
    
    // Intentar parsear como JSON
    let jsonData;
    try {
      jsonData = JSON.parse(data);
    } catch (e) {
      // Si no es JSON válido, devolver como texto
      jsonData = { data: data, raw: true };
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