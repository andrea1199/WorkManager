document.addEventListener('turbo:load', () => {
    const form = document.querySelector('form[data-remote="true"]');
    
    if (form) {
      form.addEventListener('ajax:success', (event) => {
        const [data, status, xhr] = event.detail;
        document.querySelector('#user-info').innerHTML = data;
      });
  
      form.addEventListener('ajax:error', (event) => {
        console.error("Errore nel caricamento dei dati");
      });
    }
  });
  