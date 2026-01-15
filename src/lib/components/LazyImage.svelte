<script>
  import { onMount } from 'svelte';
  export let src = '';
  export let alt = '';
  export let className = '';
  export let placeholder = '';
  let imageSrc = placeholder || '';
  let imgRef;
  let loaded = false;

  onMount(() => {
    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            imageSrc = src;
            observer.disconnect();
          }
        });
      });
      observer.observe(imgRef);
    } else {
      // Fallback for browsers without IntersectionObserver
      imageSrc = src;
    }
  });

  function handleLoad() {
    loaded = true;
  }
</script>

<img
  bind:this={imgRef}
  src={imageSrc}
  alt={alt}
  class={className}
  loading="lazy"
  on:load={handleLoad}
  style="filter: {loaded ? 'none' : 'blur(10px)'}; transition: filter 0.3s;"
/>

<style>
  img { 
    border-radius: 7px;
  }
</style>
