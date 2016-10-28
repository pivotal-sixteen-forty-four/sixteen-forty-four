function main() {
  const today = new Date();
  return Events({
    from_date: `${today.getUTCFullYear()}-${today.getUTCMonth()+1}-${today.getUTCDate()}`,
    to_date: `${today.getUTCFullYear()}-${today.getUTCMonth()+1}-${today.getUTCDate()}`
  });
}
