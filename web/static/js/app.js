import "phoenix_html"

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.card__description').forEach(card => {
    const charLimit = 150
    if (card.innerText.length > charLimit) {
      card.innerText = `${card.innerText.substring(0, charLimit)}...`
    }
  })
})
