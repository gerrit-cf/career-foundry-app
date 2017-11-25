export const getCsrfToken = () => {
  const csrfTags = document.getElementsByName('csrf-token')
  const csrfTag = csrfTags[0]

  if (csrfTags.length !== 1) return

  return csrfTag.getAttribute('content')
}
