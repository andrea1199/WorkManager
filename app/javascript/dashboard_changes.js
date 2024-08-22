document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');
  const submitButton = document.querySelector('input[type="submit"]');
  const initialFormData = new FormData(form);

  function isFormChanged() {
    const currentFormData = new FormData(form);
    for (let [key, value] of currentFormData.entries()) {
      if (initialFormData.get(key) !== value) {
        return true;
      }
    }
    return false;
  }

  form.addEventListener('input', () => {
    submitButton.disabled = !isFormChanged();
  });
});
